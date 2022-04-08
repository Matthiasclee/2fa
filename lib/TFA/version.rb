module TFA
  @@version = {
    major: 0,
    minor: 0,
    patch: 2,
    extra: [
    ]
  }

  def self.version
    "#{@@version[:major]}.#{@@version[:minor]}.#{@@version[:patch]}#{"." if @@version[:extra].length > 0}#{@@version[:extra].join(".")}"
  end
end

