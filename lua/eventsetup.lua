sign = interaction:new(0, 1000, 
{
 {words = 'Dear Bomb Diffuser, I have important information regarding the "bomb". I left this note outside your house because its confidential,'},
 {words = 'Please meet me in front of my house (The purple one) at 2 o clock. My name is Arrrnold, thank you (Keep this top secret)'},

 }, start.coords[7][6], 1)
 
 
interaction:new(0, 180, 
{
 {words = 'Tooper: Okay before we start talking, I dont know ANYTHING about the bomb and I definitely dont secretly go by the name "Pooter". Got it?'},
 {words = 'Okay now that we got that straight I dont really have anything else to say, so I will see you later.........nerd.'},

 }, tooper, 2)
 
 interaction:new(290, 1000, 
{
 {words = 'Clara: When Tooper and I kissed for the first time I thought I saw a grouper.'},
 {words = 'Whats a grouper? Well If you dont know already Im not gonna tell you because that would make this puzzle too easy'},

 }, clara, 2)
 
 
opening = cinematic:new(
{
 {words = 'Clara: Thank goodness you came to our town to diffuse our bomb! We have provided you with this house while you are here - Press Z - '},
 {words = 'The bomb will blow up in 10 hours, I hope you can find it and diffuse it! The time right now is 0 o clock. In this world 1 hour = 1 minute'},
 {words = 'Press space bar to jump, you can jump on lots of stuff like dark blocks, trees, and rooftops.'},
 {words = 'I wish you good luck, please dont get us all blown up!'},


 }, 1, 0.5)

opening.triggerGo = true

interaction:new(0, 120, 
{
 {words = 'Arrrnold: Hey you are early. Unfortunately this hour of day isnt confidential enough for me. Come back when I asked'},

 }, arrrnold, 2)
 
interaction:new(120, 150, 
{
 {words = 'Arrrnold: Bomb Diffuser! There you are, I am glad you responded to my letter.'},
 {words = 'I wanted this meeting to be tottaly top secret. Thats why I chose my front lawn as the ideal meeting spot.'},
 {words = 'Anyways, lets get down to bomb buisiness. I found two notes lying to the left of the forest lake on the right hand side of town'},
 {words = 'Looks like they are classified notes sent from one of the bombers from someone named "Pooter". I wonder who that is?'},
 {words = 'They seem to be written as some sort of riddles or code. Im sure this was in case the notes fell into the wrong hands.'},
 {words = 'These notes are classified and I dont want anyone besides you and me to see them, so I taped them to the front of my house'},
 {words = 'Please, check them out and diffuse this bomb!'},

}, arrrnold, 2)
 
 
 interaction:new(120, 1000,

{
 {words = 'At 8 o clock, meet me UNDER where Clara and I first kissed and we will discuss the diffusion method.'},
 {words = 'If we see anyone go near us, we must stop talking - Pooter'},

 }, arrrhouse.coords[5][17], 1)
 
 
 interaction:new(120, 1000,

{
 {words = 'If x = the maximum number of times Monfred says REPENT in a row, meet me at x o clock.'},
 {words = 'I will be underneath the exclamation point in town. Meet me there and we will go to where the bomb is located - Pooter'},

 }, arrrhouse.coords[5][20], 1)
 