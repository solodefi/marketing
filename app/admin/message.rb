ActiveAdmin.register Message do

  permit_params :conversation_id, :body, :user_id, :read

end
