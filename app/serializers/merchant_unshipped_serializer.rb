class MerchantUnshippedSerializer
  include JSONAPI::Serializer
  attributes :name, :potential_revenue
end
