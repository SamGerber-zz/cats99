class CatRentalRequest < ActiveRecord::Base
  STATUS = ['PENDING', 'APPROVED', 'DENIED']

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: STATUS
  validate :not_overlapping

  belongs_to :cat,
    class_name: "Cat",
    primary_key: :id,
    foreign_key: :cat_id


  def intialize(*args)
    super(*args)
    self.status = "PENDING"
  end

  def overlapping_requests
    CatRentalRequest.where(<<-SQL)
      cat_id = #{self.cat_id} AND #{"id != #{self.id} AND" if id}
        (start_date, end_date) OVERLAPS ('#{self.start_date}'::DATE, '#{self.end_date}'::DATE)
    SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_approved_requests?
    overlapping_approved_requests.count == 0 ? false : true
  end


  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_requests.each(&:deny!)
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end


  private

  def not_overlapping
    if overlapping_approved_requests? && self.status == "APPROVED"
      errors[:base] << "cat already in use"
    end
  end

end
