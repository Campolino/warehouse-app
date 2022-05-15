class ProductModel < ApplicationRecord
  validates :name, :weight, :height, :width, :depth, :sku, presence: true
  validates :weight, :height, :width, :depth, numericality: { greater_than: 0 }
  validates :sku, length: { is: 20 }
  validates :sku, uniqueness: true


  belongs_to :supplier
end
