class Cat < ActiveRecord::Base
  COLORS = ['white', 'black', 'red', 'blue', 'cream', 'brown', 'cinnamon']
  SEX = ['M', 'F']

  validates :name, :birth_date, :sex, :color, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: SEX

  def age
    (Date.today - self.birth_date) / 365
  end

end
