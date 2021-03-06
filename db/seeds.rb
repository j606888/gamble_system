user = User.create(email: 'test@test.com', password: 'testtest', name: 'Test')
user1 = User.create(email: 'test1@test.com', password: 'testtest', name: 'Test1')
user2 = User.create(email: 'test2@test.com', password: 'testtest', name: 'Test2')
user3 = User.create(email: 'test3@test.com', password: 'testtest', name: 'Test3')

room = Room.create(name: '丁之家')
Room.create(name: '黑鮪魚')
Room.create(name: '要你命3000')
Room.create(name: 'Australia Show')

p1 = Player.create(name: 'James', nickname: 'J', hidden: false, room: room)
p2 = Player.create(name: 'Steve', nickname: 'S', hidden: false, room: room)
p3 = Player.create(name: '莊子E', nickname: 'E', hidden: false, room: room)
p4 = Player.create(name: '銷中停', nickname: 'CR', hidden: false, room: room)
p5 = Player.create(name: '東錢', nickname: '$', hidden: false, room: room)

user.add_role(:member, room)
user1.add_role(:member, room)
user2.add_role(:member, room)
user3.add_role(:member, room)

game1 = room.games.create(recorded_at: 1.month.ago, recorder: 'default@test.com')
game1.records.create(player: p1, score: 100)
game1.records.create(player: p2, score: -200)
game1.records.create(player: p5, score: 100)

game2 = room.games.create(recorded_at: 2.weeks.ago, recorder: 'default@test.com')
game2.records.create(player: p1, score: 500)
game2.records.create(player: p3, score: -1000)
game2.records.create(player: p4, score: -400)
game2.records.create(player: p5, score: 100)

game3 = room.games.create(recorded_at: 3.days.ago, recorder: 'default@test.com')
game3.records.create(player: p2, score: -700)
game3.records.create(player: p4, score: 500)
game3.records.create(player: p5, score: 200)

game4 = room.games.create(recorded_at: 1.day.ago, recorder: 'default@test.com')
game4.records.create(player: p1, score: 600)
game4.records.create(player: p2, score: 300)
game4.records.create(player: p3, score: -1200)
game4.records.create(player: p4, score: -200)
game4.records.create(player: p5, score: 500)