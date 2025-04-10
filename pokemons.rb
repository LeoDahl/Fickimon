class Pokemon
  attr_accessor :name, :id, :lvl, :xp, :maxhp, :hp
  def initialize(name, pokemon_id,maxhp,hp, lvl, xp)
    @id = pokemon_id
    @name = name
    @maxhp = maxhp
    @hp = hp
    @lvl = lvl
    @xp = xp
  end
  def TakeDamage(dmg)
    @hp = @hp - dmg
  end
end
Bulbasaur = Pokemon.new("Leos bulbasaur", "1",100,100, "1", "0")

