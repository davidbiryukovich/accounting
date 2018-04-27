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
    @transaction = Transaction.find(params[:id])
  end

  def create
    @transaction = Transaction.new
    @transaction.attributes = transaction_params

    if @transaction.valid?
      @transaction.save!
      redirect_to action: 'index', id: @transaction.id
    else
      render action: 'new'
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    @transaction.attributes = transaction_params

    if @transaction.valid?
      @transaction.save!
      redirect_to action: 'show', id: @transaction.id
    else
      render action: 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to action: 'index'
  end
end

private

def transaction_params
  params.require(:transaction).permit(:date, :amount, :comment, :category_id)
end
