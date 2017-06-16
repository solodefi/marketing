ActiveAdmin.register User do
	permit_params :title, :first_name, :last_name, :birthday, :email, :password, :password_confirmation, :image, :location_id, :country, :user_type, :postcode, :overview, :profession_id, skills: []

	index do 
		selectable_column
		column :user_type
		column :first_name
		column :last_name
		column :title
		column :profession
		column :email
		column :postcode
		actions
	end

	filter :email
	filter :title
	filter :postcode
	filter :profession
	# filter :location, as: :select

	form do |f|
		f.inputs "User Details" do
			f.input :user_type, as: :select, collection: User.user_types.keys, include_blank: false
			f.input :first_name
			f.input :last_name
			f.input :title
			f.input :email
			f.input :password
			f.input :password_confirmation
			f.input :birthday
			f.input :image
			f.input :postcode
			f.input :overview
			f.input :profession, :input_html => {
				:onchange => remote_request(:post, '/change_categories', {:profession_id=>"$('#user_profession_id').val()"}, :user_skills)
	    }
			# f.input :skills, as: :select, multiple: true, :collection => Category.select('distinct on(title) *'), display_name: :title, label: "Skills"
			if f.object.profession_id.present? && !f.object.new_record?
				f.input :skills, as: :select, multiple: true, :collection => Profession.find_by_id(f.object.profession_id).try(:categories), display_name: :title, label: "Skills"
	    else
			 	f.input :skills, as: :select, multiple: true, :collection => {}, display_name: :title, label: "Skills"
	    end

			# f.input :location, include_blank: false
		end
		actions
	end

	before_save do |user|
		user.skills.each do |skill|
			user.skills.delete(skill) if skill == ""
		end
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
