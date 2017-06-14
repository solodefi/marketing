ActiveAdmin.register Job do

	permit_params :title, :price, :description, :postcode, :start_date, :end_date, :user_id, :profession_id, :status, :freelancer_id, category_ids: []

	index do
		selectable_column
		column :title
		column :profession
		column "Category" do |job|
			job.str_categories
		end
		column :price
		column :postcode
		column :start_date
		column :end_date
		column :status
		column "Posted By" do |job|
			job.user
		end
		column :freelancer
		actions
	end

	show do
		attributes_table do
			row :title
			row :profession
			row('Category') {|job| job.str_categories}
			row :price
			row :description
			row :postcode
			row :start_date
			row :end_date
			row :status
			row('Posted By') {|job| job.user}
			row :freelancer
			row :created_at
			row :updated_at
			row :started_at
			row :ended_at
		end
	end

	filter :title
	filter :price
	filter :postcode
	filter :status
	filter :user, :label => "Posted By"
	filter :profession
	# filter :category_ids, as: :select, :collection => Category.all, display_name: :title, label: "Category"

	form do |f|
		f.inputs "Job Details" do
			f.input :title
			f.input :price
			f.input :description
			f.input :postcode
			f.input :start_date
			f.input :end_date
			f.input :status
			f.input :user, :label => "Posted By", :include_blank => false
			f.input :freelancer
			# f.input :profession_id, as: :select, :collection => Profession.all, display_name: :title, label: "Profession"
			# f.input :category_ids, as: :select, multiple: true, :collection => Category.all, display_name: :title, label: "Category"
			f.input :profession, :input_html => {
	      :onchange => remote_request(:post, '/change_categories', {:profession_id=>"$('#job_profession_id').val()"}, :job_category_ids)
	    }
	    # f.input :category_ids, as: :select, multiple: true, :collection => {}, display_name: :title, label: "Category", input_html: {disabled: true}
	    if f.object.profession_id.present? && !f.object.new_record?
	    	f.input :category_ids, as: :select, multiple: true, :collection => Profession.find_by_id(f.object.profession_id).try(:categories), display_name: :title, label: "Category"
	    else
	    	f.input :category_ids, as: :select, multiple: true, :collection => {}, display_name: :title, label: "Category"
	    end
	    
		end
		f.actions
	end

	before_save do |job|

			job.category_ids.each do |category_id|
				job.category_ids.delete(category_id) if category_id == ""
			end
	
	end
end