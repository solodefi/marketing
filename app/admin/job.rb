ActiveAdmin.register Job do

	permit_params :title, :price, :description, :postcode, :start_date, :end_date, :user_id, category_ids: []

	index do
		selectable_column
		column :title
		column "Category" do |job|
			job.str_categories
		end
		column :price
		column :description
		column :postcode
		column :start_date
		column :end_date
		column "Posted By" do |job|
			job.user
		end
		actions
	end

	show do
		attributes_table do
			row :title
			row('Category') {|job| job.str_categories}
			row :price
			row :description
			row :postcode
			row :start_date
			row :end_date
			row('Posted By') {|job| job.user}
			row :created_at
			row :updated_at
		end
	end

	filter :title
	filter :price
	filter :postcode
	filter :user, :label => "Posted By"
	# filter :category_ids, as: :select, :collection => Category.all, display_name: :title, label: "Category"

	form do |f|
		f.inputs "Job Details" do
			f.input :title
			f.input :price
			f.input :description
			f.input :postcode
			f.input :start_date
			f.input :end_date
			f.input :user, :label => "Posted By", :include_blank => false
			f.input :category_ids, as: :select, multiple: true, :collection => Category.all, display_name: :title, label: "Category"
		end
		f.actions
	end

	before_save do |job|
		job.category_ids.each do |category_id|
			job.category_ids.delete(category_id) if category_id == ""
		end
	end
end
