class WithdrawsController < ApplicationController
  
  def new
    if current_user.get_paid_email?
      @withdraw = Withdraw.new
      @withdraw.user_id = current_user.id
      @withdraw.email = current_user.get_paid_email
    else
      redirect_to settings_path
    end
    
  end

  def create
    @withdraw = Withdraw.new(withdraw_params)

    if @withdraw.amount > current_user.available_balance
      render :new
    else
      response = ::EXPRESS_GATEWAY.transfer @withdraw.amount*100, @withdraw.email, :subject => 'Structured Thinking Payment', :notes => "Thank you for using Structured Thinking"

      if response.success?
        @withdraw.save
        redirect_to freelancer_history_transactions_url
      else 
        redirect_to on_failed_withdraws_url
      end
    end
    
  end

  def on_failed
  end

private
  def withdraw_params
    params.require(:withdraw).permit(:user_id, :email, :amount)
  end

end
