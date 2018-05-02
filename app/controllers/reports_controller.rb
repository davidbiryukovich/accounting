class ReportsController < ApplicationController

  def index
    redirect_to action: 'transactions'
  end

  def transactions
    relation = Transaction

    relation = relation.where('date >= ?', params[:from_date]) if params[:from_date].present?
    relation = relation.where('date <= ?', params[:to_date]) if params[:to_date].present?

    @transactions = relation.all
  end

end
