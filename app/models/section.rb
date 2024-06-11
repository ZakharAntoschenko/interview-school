# frozen_string_literal: true

class Section < ApplicationRecord
  EARLIEST_TIME_TO_START = "07:30 AM"
  LATEST_TIME_TO_START = "10:00 PM"

  has_many :section_students, dependent: :destroy
  has_many :students, through: :section_students
  belongs_to :classroom
  belongs_to :subject
  belongs_to :teacher

  validates :start_time, :schedule_kind, :time_duration_kind, presence: true
  validates :start_time, format: { with: /\A\d{2}:\d{2} (AM|PM)\z/i, message: "format should be in HH:MM AM/PM" }
  validates :teacher, inclusion: { in: ->(section) { section.subject&.teachers }, message: "Teacher can't teach a subject" }
  validate :start_time_within_range

  enum schedule_kind: { everyday: 0, monday_wednesday_friday: 1, tuesday_thursday: 2 }
  enum time_duration_kind: { sixty_mins: 0, ninety_mins: 1 }

  def display_name
    "#{subject.name}: #{schedule_kind}, #{time_duration_kind} #{start_time}"
  end

  def overlaps?(other_section)
    days_overlapping?(other_section) && time_overlapping?(other_section)
  end

  def durability_time_range
    start_time_obj = Time.strptime(start_time, "%I:%M %p")
    end_time_obj = start_time_obj + duration_minutes.minutes
    start_time_obj..end_time_obj
  end

  def schedule_days
    case schedule_kind
    when 'everyday'
      %w[Monday Tuesday Wednesday Thursday Friday]
    when 'monday_wednesday_friday'
      %w[Monday Wednesday Friday]
    when 'tuesday_thursday'
      %w[Tuesday Thursday]
    else
      []
    end
  end

  private

  def days_overlapping?(other_section)
    schedule_days & other_section.schedule_days
  end

  def time_overlapping?(other_section)
    durability_time_range.overlaps?(other_section.durability_time_range)
  end

  def start_time_within_range
    return unless start_time.present?

    parsed_time = Time.strptime(start_time, "%I:%M %p")
    start_time = Time.parse(EARLIEST_TIME_TO_START)
    end_time = Time.parse(LATEST_TIME_TO_START)

    unless parsed_time.between?(start_time, end_time)
      errors.add(:start_time, "should be between #{EARLIEST_TIME_TO_START} and #{LATEST_TIME_TO_START}")
    end
  end

  def duration_minutes
    case time_duration_kind
    when 'sixty_mins' then 60
    when 'ninety_mins' then 90
    else 0
    end
  end
end
