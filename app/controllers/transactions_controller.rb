class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def edit

  end

  def create
    @transaction = Transaction.new
    @transaction.attributes = transaction_params

    if @transaction.valid?
      @transaction.save!
      redirect_to action: 'show', id: @transaction.id
    else
      render action: 'new'
    end
  end

  def update

  end

  def destroy

  end
end


private

def transaction_params
  params.require(:transaction).permit(:date, :amount, :comment, :category_id)
end
