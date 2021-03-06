module TransferToApi
  class Product
    attr_reader :operator, :destination_currency, :skuid, :open_range,
    :product_type, :fx_local_currency, :fx_rate

    def initialize(response)
      @open_range = response.data[:open_range] || "0"
      @operator = TransferToApi::Operator.new(response.data[:country],
                                              response.data[:countryid],
                                              response.data[:operator],
                                              response.data[:operatorid])
      @destination_currency = response.data[:destination_currency]
      @skuid = response.data[:skuid]
      @product_type = response.data[:product_type]
      @fx_local_currency = response.data[:fx_local_currency]
      @fx_rate = response.data[:fx_rate]
    end

    # product_types options seem to be:
    # - 'Airtime PIN Less'
    # - 'Airtime PIN Based'
    # - 'Grocery PIN Based'
    # - 'Mobile Broadband PIN'
    # - 'LandLine PIN Less'
    # - 'Television PIN Less'
    # - 'Electricity PIN Based'
    # - 'Grocery PIN Less'
    # - 'Mobile Broadband'
    # - 'Television PIN Based'
    def is_pin_based?
      @product_type.include?('PIN Based')
    end
  end
end
