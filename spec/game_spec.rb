require 'game'

describe Game do
  it 'user wins the game' do
    game = Game.new('небо')
    expect(game.status). to eq :in_progress

    game.next_step('н')
    game.next_step('о')
    game.next_step('о')
    game.next_step('ё')
    game.next_step('р')
    game.next_step('б')

    expect(game.errors).to eq 1
    expect(game.status).to eq :won
  end

  it 'user lost the game' do
    game = Game.new('небо')

    game.next_step('у')
    game.next_step('у')
    game.next_step('к')
    game.next_step('а')
    game.next_step('о')
    game.next_step('о')
    game.next_step('в')
    game.next_step('ц')
    game.next_step('щ')
    game.next_step('Щ')
    game.next_step('Д')

    expect(game.errors).to eq 7
    expect(game.status).to eq :lost
  end
end