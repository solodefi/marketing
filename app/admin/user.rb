ActiveAdmin.register User do
	permit_params :first_name, :last_name, :birthday, :email, :password, :password_confirmation, :photo_url, :country, :user_type

	index do 
		selectable_column
		column :user_type
		column :first_name
		column :last_name
		column :email
		column :country_name
		actions
	end

	filter :email
	filter :country, as: :select

	form do |f|
		f.inputs "User Details" do
			f.input :user_type, as: :select, collection: User.user_types.keys, include_blank: false
			f.input :first_name
			f.input :last_name
			f.input :email
			f.input :password
			f.input :password_confirmation
			f.input :birthday
			f.input :photo_url
			f.input :country
		end
		actions
	end

	# Allow to update user without password
	controller do
		def update
			if params[:user][:password].blank?
				params[:user].delete("password")
				params[:user].delete("password_confirmation")
			end
			super
		end
	end
	
end
