class User::ParameterSanitizer < Devise::ParameterSanitizer
  private
  def sign_in
    default_params.permit(:email, :password)
  end
  def sign_up
    default_params.permit(:name, :sex_id, :major_id, :email, :time_zone, :password, :password_confirmation)
    #default_params.permit(:name, :sex_attributes => [ :sex_id ], :major_attributes => [ :major_id ], :email, :time_zone, :password, :password_confirmation)
    #params.require(resource_name).permit(:name, sex:[ :sex_id ], major:[ :major_id ], :email, :time_zone, :password, :password_confirmation)
  end
  def account_update
    default_params.permit(:name, :sex_id, :major_id, :email, :time_zone, :password, :password_confirmation, :current_password)
    #default_params.permit(:name, :sex_attributes => [ :sex_id ], :major_attributes => [ :major_id ], :email, :time_zone, :password, :password_confirmation, :current_password)
  end
end