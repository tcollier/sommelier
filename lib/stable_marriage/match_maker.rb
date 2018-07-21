class StableMarriage
  class MatchMaker
    def initialize(match_set)
      @match_set = match_set
    end

    def proposals
      proposals = {}
      (0...match_set.max_suitor_preferences).each do |round|
        suitee_proposals = {}
        match_set.each_suitor_prefs do |suitor, suitor_prefs|
          if round < suitor_prefs.count && !proposals.key?(suitor)
            suitee = match_set.suitee_preferred_at(suitor, round)
            suitee_proposals[suitee] ||= []
            suitee_proposals[suitee] << suitor
          end
        end

        suitee_proposals.each do |suitee, suitors|
          winning_suitor = match_set.most_preferred(suitee, suitors)
          proposals[winning_suitor] = suitee
          suitors.each do |suitor|
            proposals.delete(suitor) unless suitor == winning_suitor
          end
        end
      end

      proposals
    end

    private

    attr_reader :match_set
  end
  private_constant :MatchMaker
end
