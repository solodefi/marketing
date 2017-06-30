class DepositsController < EndUserBaseController

  def on_confirm
    @transaction = Transaction.find(params[:transaction_id])
    @deposit = Deposit.find(params[:deposit_id])
  end

  def perform_purchase
    @transaction = Transaction.find(params[:transaction_id])
    @deposit = Deposit.find(params[:deposit_id])

    details = ::EXPRESS_GATEWAY.details_for(@deposit.token)
    @deposit.payer_id = details.payer_id

    response = ::EXPRESS_GATEWAY.purchase(@deposit.amount, ip: @deposit.ip, token: @deposit.token, payer_id: @deposit.payer_id)

    if response.success?
      redirect_to on_success_deposits_url(transaction_id: @transaction.id, deposit_id: @deposit.id)
    else
      redirect_to on_failed_deposits_url(transaction_id: @transaction.id, deposit_id: @deposit.id)
    end
  end

  def on_failed
    @transaction = Transaction.find(params[:transaction_id])
    @transaction.status = 'fail'
    @transaction.save

    Deposit.find(params[:deposit_id]).destroy
  end

  def on_success
    @transaction = Transaction.find(params[:transaction_id])
    @transaction.status = 'success'
    @transaction.save
  end
end
