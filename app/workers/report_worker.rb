class ReportWorker
    include Sidekiq::Worker
  
    def perform(report_type)
        puts "\n\n\n\n Hello from MyWorker"
        p report_type
        case report_type
          when 'highest_price'
            puts "performing highest_price"
            highest_price_report = Report.find_or_initialize_by(report_type: :highest_price)
            highest_price_report.update(report_data: highest_price_data)
      
          when 'lowest_price'
            puts "performing lowest_price"
            lowest_price_report = Report.find_or_initialize_by(report_type: :lowest_price)
            lowest_price_report.update(report_data: lowest_price_data)
      
      
          when 'VM_with_maximum_number_of_dop_disks'
            puts "performing VM_with_maximum_number_of_dop_disks"
            max_dop_disk_number_report = Report.find_or_initialize_by(report_type: :VM_with_maximum_number_of_dop_disks)
            max_dop_disk_number_report.update(report_data: data_of_VM_with_maximum_number_of_dop_disks)
      
          when 'VM_with_maximum_vol_of_dop_disks'
            puts "performing VM_with_maximum_vol_of_dop_disks"
            max_dop_disk_volume_report = Report.find_or_initialize_by(report_type: :VM_with_maximum_vol_of_dop_disks)
            max_dop_disk_volume_report.update(report_data: data_of_VM_with_maximum_vol_of_dop_disks)
        end
        puts "after working \n\n\n"
    end
  
    def highest_price_data
        "Самые дорогие ВМ #{prices_vm.reverse.first(10)}"
    end
      
    def lowest_price_data
        "Самые дешевые ВМ #{prices_vm.first(10)}"
    end
      
    def prices_vm
        prices = {}
        Order.all.each do |order|
          url = URI('http://calc_service:4567/price')
          paramses = order.options
          url.query = URI.encode_www_form(paramses)
          res = Net::HTTP.get_response(url)
          prices[order.id] = res.body[15...23].to_f
        end
        prices.to_a.sort_by(&:last)
    end
  
  
    def data_of_VM_with_maximum_number_of_dop_disks
        dop_counts = {}
        Order.all.each.each do |order|
          dop_counts[order.id] = order.options['dop'].to_a.count
        end
      
        sorted_dop_counts = dop_counts.to_a.sort_by(&:last)
        "ВМ у которых подключено больше всего дополнительных дисков (по количеству штук): #{sorted_dop_counts.reverse.first(10)}"
      end
      
      
      def data_of_VM_with_maximum_vol_of_dop_disks
        dop_volumes = {}
        Order.all.each do |order|
          dop_volumes[order.id] = order.options['dop'].to_a.map {|disk| disk['hdd_capacity'] }.sum
        end
      
        sorted_dop_volumes = dop_volumes.to_a.sort_by(&:last)
        "ВМ у которых подключено больше всего дополнительных дисков (по объему): #{sorted_dop_volumes.reverse.first(10)}"
      end
end