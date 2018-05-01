class TransactionsController < ApplicationController

  def index
    @transactions = user_transactions.all
  end

  def show
    @transaction = find_transaction
  end

  def new
    @transaction = Transaction.new(date: Date.today)
  end

  def edit
    @transaction = find_transaction
  end

  def create
    @transaction = Transaction.new
    @transaction.attributes = transaction_params
    check_category(@transaction)

    if @transaction.valid?
      @transaction.save!
      redirect_to action: 'index', id: @transaction.id
    else
      render action: 'new'
    end
  end

  def update
    @transaction = find_transaction
    @transaction.attributes = transaction_params
    check_category(@transaction)

    if @transaction.valid?
      @transaction.save!
      redirect_to action: 'show', id: @transaction.id
    else
      render action: 'edit'
    end
  end

  def destroy
    @transaction = find_transaction
    @transaction.destroy
    redirect_to action: 'index'
  end

  private

  def user_transactions
    Transaction.where(category_id: current_user.categories.map(&:id))
  end

  def find_transaction
    result = user_transactions.find_by(id: params[:id])
    render_404 unless result
    result
  end

  def check_category(transaction)
    transaction.category_id = nil if transaction.category&.user_id != current_user.id
  end

  def transaction_params
    params.require(:transaction).permit(:date, :amount, :comment, :category_id)
  end
end