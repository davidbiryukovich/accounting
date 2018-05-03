class ReportsController < ApplicationController

  def index
    redirect_to action: 'transactions'
  end

  def transactions
    relation = Transaction.where(category_id: current_user.categories.map(&:id))

    relation = relation.where('date >= ?', params[:from_date]) if params[:from_date].present?
    relation = relation.where('date <= ?', params[:to_date]) if params[:to_date].present?
    relation = relation.where('category_id = ?', params[:category_id]) if params[:category_id].present?

    @transactions = relation.all
  end

end
