class LoadsheddingStatus
  NONE = "0"
  STAGE_1 = "1"
  STAGE_2 = "2"
  STAGE_3A = "3a"
  STAGE_3B = "3b"

  def self.none
    LoadsheddingStatus.new(NONE)
  end

  def self.stage1
    LoadsheddingStatus.new(STAGE_1)
  end

  def self.stage2
    LoadsheddingStatus.new(STAGE_2)
  end

  def self.stage3a
    LoadsheddingStatus.new(STAGE_3A)
  end

  def self.stage3b
    LoadsheddingStatus.new(STAGE_3B)
  end

  attr_reader :stage
  def initialize(stage)
    @stage = stage
  end
end

