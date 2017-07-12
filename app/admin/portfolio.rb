ActiveAdmin.register Portfolio do
  permit_params :title, :overview, :completion_date
  index do 
    selectable_column
    column :title
    column :overview
    column :completion_date
    actions
  end

  filter :title
  filter :overview
  # filter :location, as: :select

  form do |f|
    f.inputs "Portfolio Details" do
      f.input :title
      f.input :overview
      f.input :completion_date
    end
    actions
  end

  # Allow to update user without password
  controller do

  end
  
end
