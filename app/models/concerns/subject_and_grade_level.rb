# coding: utf-8
module SubjectAndGradeLevel
  extend ActiveSupport::Concern

  included do
    validate :validate_grade_level
    validate :validate_subject
  end

  def validate_grade_level
    # Checks that all grade levels that apply to this mapset are 0-12
    # (0 being kindergarten) and that there are no duplicates
    if !grade_level.is_a?(Array)
      errors.add(:grade_level, 'must be an array')
    else
      if grade_level.detect { |d| !(0..12).cover?(d) }
        errors.add(:grade_level, 'can only contains numbers 0-12')
      end
      if grade_level.uniq.length != grade_level.length
        errors.add(:grade_level, 'cannot contain duplicates')
      end
    end
  end

  def validate_subject
    # Checks that all subjects that apply to this mapset are in the list of
    # allowed subjects and that there are no duplicates
    if !subject.is_a?(Array)
      errors.add(:subject, 'must be an array')
    else
      # the first option is always blank - remove it
      subject.reject!(&:blank?)
      if subject.detect { |d| !self.class.subject_hash.keys.include?(d) }
        errors.add(:subject, 'can only contain specific subjects')
      end
      if subject.uniq.length != subject.length
        errors.add(:subject, 'cannot contain duplicates')
      end
    end
  end

  class_methods do
    def grade_levels
      { 'PreK-2' => '0, 1, 2', '3-5' => '3, 4, 5', '6-8' => '6, 7, 8', '9-12' => '9, 10, 11, 12' }
    end

    def subjects
      [
        ['US History', [
          ['The Americas to 1620', 'three-worlds-meet'], # Kept old DB name when renaming subject
          ['Colonization and Settlement (1585-1763)', 'colonization-and-settlement'],
          ['Revolution and the New Nation (1754-1820s)', 'revolution-and-the-new-nation'],
          ['Expansion, Industrialization & Reform (1801-1861)', 'expansion-and-reform'],
          ['Civil War & Reconstruction (1850-1877)', 'civil-war-and-reconstruction'],
          ['Development of Industrial United States (1870-1900)', 'development-of-industrial'],
          ['The Emergence of Modern America (1890-1930)', 'emergence-of-modern-america'],
          ['The Great Depression & WWII (1929-1945)', 'great-depression-and-wwii'],
          ['1945 to the Present', 'postwar-us'], # Kept old DB name when renaming subject
          ['American History Across the Eras', 'american-history'],
          ['Civics and Government', 'civics-government']
        ]],
        ['World History', [
          ['Emergence of the First Global Age (1450-1770)', 'first-global-age'],
          ['Age of Revolutions (1750-1914)', 'age-of-revolutions'],
          ['A Half-Century of Crisis and Achievement (1900-1945)', 'crisis-and-achievement'],
          ['1945 to the Present', 'since-1945'],
          ['World History Across the Eras', 'world-history']
        ]],
        ['Boston Public Schools', [
          ['Boston\'s Changing Geography', 'bostons-changing-geography'],
          ['Boston Neighborhoods', 'bostons-neighborhoods']
        ]],
        # These would be better as <option> elements without a group,
        # but it is much easier to put them in an <optgroup> with a "label"
        ['Other', [
          ['Geography', 'geography-other'],
          ['Map Projections', 'map-projections'],
          ['Science', 'general-science'],
          ['Classical Imagery & Art', 'classical-art'],
          ['Literary Maps', 'literary-maps'],
          ['Math and Maps', 'math-maps'],
          ['Miscellaneous', 'miscellaneous-other']
        ]]
      ]
    end

    def subject_title_for_id(id)
      subject_hash[id]
    end

    def subject_hash
      subject_pairs = {}
      subjects.each do |group|
        group[1].each do |opt|
          subject_pairs[opt[1]] = opt[0]
        end
      end
      subject_pairs
    end
  end

  def grade_level_value
    selected = self.class.grade_levels.reject do |_, grade_csv|
      # if the grade_level array does not contain all the values in grade_csv, reject it
      !(grade_csv.split(',').map(&:to_i) - grade_level).empty?
    end
    selected.values
  end

  def grade_level_display
    # Grade 0 is "K"idergarten
    grade_level.map { |x| x == 0 ? 'K' : x }.join(', ')
  end

  def subject_display
    subject.map(&self.class.method(:subject_title_for_id)).reject(&:blank?).join(', ')
  end
end
