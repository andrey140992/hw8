class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def approve
    render json: params[:name]
    
  end


  def calc
    puts rand(10)
    render json: "ok"
  end

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  
  end


  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def perform_order
    order = Order.find(params[:id])
    order_performer_client = OrderPerformerClientService.new('vm.control')
    response = order_performer_client.call(order.options)
  
    order.update(status: 10)
    render json: response
  end


  def make_report
    ReportWorker.perform_async(params[:report_type])
    render json: 'построение отчета запущено'
  end


  def check
    if !possible_orders
      render json: "result: false, error: 503 Service Unavailable"
      return
    end

    if possible_cost > current_user.balance.to_f
      render json: "result: false, error: 406 Not Acceptable"
      return
    end

    puts 200
    render json: "result: true, total: #{@cost}, balance: #{current_user.balance.to_f}, balance_after_transaction: #{current_user.balance.to_f - @cost}  "
  end


  def possible_cost
    puts "\n\n\n possible_cost"
    url = URI('http://calc_service:4567/price')
    paramses = { :os => params[:os], :cpu => params[:cpu], :ram => params[:ram], :hdd_type => params[:hdd_type], :hdd_capacity => params[:hdd_capacity]}
    url.query = URI.encode_www_form(paramses)
    res = Net::HTTP.get_response(url)
    puts res.body if res.is_a?(Net::HTTPSuccess)
    @cost = res.body[15...23].to_f
    puts "\n\n\n\n"
    return @cost
  end


  def possible_orders
    result = Net::HTTP.get(URI.parse('http://possible_orders.srv.w55.ru'))
    @specs =  JSON.parse(result)

    @specs['specs'].each do |conf|
     
          puts "\n\n\n\n possible_orders conditions"
          puts conf['os']
          p conf['os'] == params['os']
          p conf['cpu'].include?(params['cpu'].to_i)
          p conf['ram'].include?(params['ram'].to_i)
          p conf['hdd_type'].include?(params['hdd_type'])
          p conf['hdd_type'].include?(params['hdd_type']) && conf['hdd_capacity'][params['hdd_type']]['from'] <= params["hdd_capacity"].to_i
          p conf['hdd_type'].include?(params['hdd_type']) && conf['hdd_capacity'][params['hdd_type']]['to'] >= params["hdd_capacity"].to_i
          puts "\n\n\n"

          if  conf['os'].include?(params['os']) &&
              conf['cpu'].include?(params['cpu'].to_i) &&
              conf['ram'].include?(params['ram'].to_i) &&
              conf['hdd_type'].include?(params['hdd_type']) &&
              conf['hdd_capacity'][params['hdd_type']]['from'] <= params["hdd_capacity"].to_i &&
              conf['hdd_capacity'][params['hdd_type']]['to'] >= params["hdd_capacity"].to_i
          return true
        end
      end  
    false  
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :status, :cost)
    end


end






