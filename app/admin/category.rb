ActiveAdmin.register Category do

	# belongs_to :Job
	permit_params :title, :description

end
