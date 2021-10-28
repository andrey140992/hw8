# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders
  has_one :passport_data
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
