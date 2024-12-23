require "debug"

class Bowling
  STRIKE = "X".freeze
  SPARE = "/"
  FULL_HIT = 10

  def self.call(...)
    new(...).call
  end

  def initialize(scores:)
    @scores = scores
    @total_score = 0
  end

  def call
    scores[0..8].each_with_index do |frame, i|
      @total_score = @total_score + calculate_frame_score(frame, i)
    end
    @total_score + calculate_final_frame(scores[9])
  end

  attr_reader :scores

  private

  def calculate_frame_score(frame, i)
    if frame.include?(STRIKE)
      10 + calculate_next_two_rolls(i)
    elsif frame.include?(SPARE)
      10 + calculate_next_roll(i)
    else
      frame.split("")[0].to_i
    end
  end

  def calculate_next_two_rolls(i)
    next_frame = scores[i+1]
    parsed_next_frame = parse_frame(next_frame)
    return parsed_next_frame.first(2).sum if parsed_next_frame.count >= 2
    10 + parse_frame(scores[i+2])[0]
  end

  def calculate_next_roll(i)
    next_frame = scores[i+1]
    parse_frame(next_frame)[0]
  end

  def parse_frame(frame)
    return [ FULL_HIT ] if frame == STRIKE
    return parse_final_frame(frame) if frame.length == 3
    if frame.include?(SPARE)
      data = frame.split("")
      [ data[0].to_i, FULL_HIT - data[0].to_i ]
    else
      [ frame.split("")[0].to_i, 0 ]
    end
  end

  def calculate_final_frame(frame)
    total = 0
    frame.split("").map do |char|
      total = total + parse_score(char)
    end
    total
  end

  def parse_final_frame(final_frame)
    final_frame.split("").map do |char|
      if char == STRIKE
        10
      else
        char.to_i
      end
    end
  end

  def parse_score(char)
    return 10 if char == STRIKE
    char.to_i
  end
end
