ActiveAdmin.register Transaction do

permit_params :sender_id, :recipient_id, :amount, :status

end
