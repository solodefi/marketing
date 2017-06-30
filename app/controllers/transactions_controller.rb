class TransactionsController < EndUserBaseController

  def new
    @transaction = Transaction.new
    @transaction.job_id = params[:job_id]
    @transaction.sender_id = @transaction.job.user_id
    @transaction.recipient_id = @transaction.job.freelancer_id
    @transaction.status = 'init'
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.save

    deposit = Deposit.new
    deposit.user_id = @transaction.sender_id
    deposit.amount = @transaction.amount
    deposit.save

    checkout_paypal(deposit)

    # respond_to do |format|
    #   if @transaction.save
    #     format.html { redirect_to in_progress_details_jobs_url(id: @transaction.job_id), notice: 'The payment has been sent successfully.' }
    #   else
    #     format.html { render :new }
    #   end
    # end
  end

  def client_history
    @transactions = current_user.sent_transactions.where(status: "success")
  end

  def freelancer_history
    @transactions = current_user.received_transactions.where(status: "success")
    @withdraws = current_user.withdraws
  end

private

  def checkout_paypal(deposit)
    response = ::EXPRESS_GATEWAY.setup_purchase(
      deposit.amount*100, 
      ip: request.remote_ip, 
      return_url: on_confirm_deposits_url(deposit_id: deposit.id, transaction_id: @transaction.id), 
      cancel_return_url: on_failed_deposits_url(deposit_id: deposit.id, transaction_id: @transaction.id),
      currency: "GBP",
      allow_guest_checkout: true,
      items: [{
        notice_no: "Structured Thinking",
        description: "Pay for work and services for " + @transaction.recipient.name,
        quantity: "1",
        amount: deposit.amount*100}]
      )

    # To withdraw money
    # response = ::EXPRESS_GATEWAY.transfer 10, 'akirabuyerthird@gmail.com', :subject => 'The money I owe you', :notes => "sorry"

    deposit.token = response.token
    deposit.ip = request.remote_ip
    deposit.save

    redirect_to ::EXPRESS_GATEWAY.redirect_url_for(response.token) and return 
  end

  def transaction_params
    params.require(:transaction).permit(:job_id, :sender_id, :recipient_id, :amount, :status)
  end


end
