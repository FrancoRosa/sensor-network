ActiveAdmin.register Device do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :latitude, :longitude, :description, :tx_period, :tx_slot, :rx_time
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :latitude, :longitude, :description, :tx_period, :tx_slot, :rx_time]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
