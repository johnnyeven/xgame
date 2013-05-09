package
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	
	import controllers.ApplicationCommand;
	
	public class ContactListener extends b2ContactListener
	{
		public function ContactListener()
		{
			super();
		}
		
		override public function BeginContact(contact:b2Contact):void
		{
			var _bodyA: b2Body = contact.GetFixtureA().GetBody();
			var _bodyB: b2Body = contact.GetFixtureB().GetBody();
			if(_bodyA.GetUserData().name == "ground" || _bodyB.GetUserData().name == "ground")
			{
				trace("ground");
				ApplicationCommand.IsAtGround = true;
			}
		}
	}
}