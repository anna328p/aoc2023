# frozen_string_literal: true

class Range
  def overlap?(other)
    self.begin == other.begin || cover?(other.begin) || other.cover?(self.begin)
  end
end
