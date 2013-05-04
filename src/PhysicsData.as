package
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
    import flash.utils.Dictionary;

    public class PhysicsData extends Object
	{
		// ptm ratio
        public var ptm_ratio:Number = 30;
		
		// the physcis data 
		var dict:Dictionary;
		
        //
        // bodytype:
        //  b2_staticBody
        //  b2_kinematicBody
        //  b2_dynamicBody

        public function createBody(name:String, world:b2World, bodyType:uint, userData:*):b2Body
        {
            var fixtures:Array = dict[name];

            var body:b2Body;
            var f:Number;

            // prepare body def
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = bodyType;
            bodyDef.userData = userData;

            // create the body
            body = world.CreateBody(bodyDef);

            // prepare fixtures
            for(f=0; f<fixtures.length; f++)
            {
                var fixture:Array = fixtures[f];

                var fixtureDef:b2FixtureDef = new b2FixtureDef();

                fixtureDef.density=fixture[0];
                fixtureDef.friction=fixture[1];
                fixtureDef.restitution=fixture[2];

                fixtureDef.filter.categoryBits = fixture[3];
                fixtureDef.filter.maskBits = fixture[4];
                fixtureDef.filter.groupIndex = fixture[5];
                fixtureDef.isSensor = fixture[6];

                if(fixture[7] == "POLYGON")
                {                    
                    var p:Number;
                    var polygons:Array = fixture[8];
                    for(p=0; p<polygons.length; p++)
                    {
                        var polygonShape:b2PolygonShape = new b2PolygonShape();
                        polygonShape.SetAsArray(polygons[p], polygons[p].length);
                        fixtureDef.shape=polygonShape;

                        body.CreateFixture(fixtureDef);
                    }
                }
                else if(fixture[7] == "CIRCLE")
                {
                    var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
                    circleShape.SetLocalPosition(fixture[8]);
                    fixtureDef.shape=circleShape;
                    body.CreateFixture(fixtureDef);                    
                }                
            }

            return body;
        }

		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["floor"] = [

										[
											// density, friction, restitution
                                            2, .2, .2,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(163/ptm_ratio, 43.5/ptm_ratio)  ,  new b2Vec2(181/ptm_ratio, 49.5/ptm_ratio)  ,  new b2Vec2(217/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 61.5/ptm_ratio)  ,  new b2Vec2(149/ptm_ratio, 44.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(299/ptm_ratio, 27.5/ptm_ratio)  ,  new b2Vec2(311/ptm_ratio, 29.5/ptm_ratio)  ,  new b2Vec2(325/ptm_ratio, 35.5/ptm_ratio)  ,  new b2Vec2(351/ptm_ratio, 58.5/ptm_ratio)  ,  new b2Vec2(258/ptm_ratio, 60.5/ptm_ratio)  ,  new b2Vec2(272.5/ptm_ratio, 39/ptm_ratio)  ,  new b2Vec2(279.5/ptm_ratio, 32/ptm_ratio)  ,  new b2Vec2(286/ptm_ratio, 28.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(461/ptm_ratio, 54.5/ptm_ratio)  ,  new b2Vec2(496/ptm_ratio, 64.5/ptm_ratio)  ,  new b2Vec2(422/ptm_ratio, 60.5/ptm_ratio)  ,  new b2Vec2(435/ptm_ratio, 54.5/ptm_ratio)  ,  new b2Vec2(447/ptm_ratio, 52.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(364/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(251/ptm_ratio, 65.5/ptm_ratio)  ,  new b2Vec2(258/ptm_ratio, 60.5/ptm_ratio)  ,  new b2Vec2(351/ptm_ratio, 58.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(496/ptm_ratio, 64.5/ptm_ratio)  ,  new b2Vec2(403/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(422/ptm_ratio, 60.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(217/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 61.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(579.5/ptm_ratio, 72/ptm_ratio)  ,  new b2Vec2(551/ptm_ratio, 38.5/ptm_ratio)  ,  new b2Vec2(568.5/ptm_ratio, 13/ptm_ratio)  ,  new b2Vec2(579.5/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(579.5/ptm_ratio, 72/ptm_ratio)  ,  new b2Vec2(533/ptm_ratio, 55.5/ptm_ratio)  ,  new b2Vec2(551/ptm_ratio, 38.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(579.5/ptm_ratio, 72/ptm_ratio)  ,  new b2Vec2(519/ptm_ratio, 62.5/ptm_ratio)  ,  new b2Vec2(533/ptm_ratio, 55.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(579.5/ptm_ratio, 72/ptm_ratio)  ,  new b2Vec2(511/ptm_ratio, 64.5/ptm_ratio)  ,  new b2Vec2(519/ptm_ratio, 62.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(364/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(376/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 68.5/ptm_ratio)  ,  new b2Vec2(251/ptm_ratio, 65.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(511/ptm_ratio, 64.5/ptm_ratio)  ,  new b2Vec2(579.5/ptm_ratio, 72/ptm_ratio)  ,  new b2Vec2(578/ptm_ratio, 72.5/ptm_ratio)  ,  new b2Vec2(384/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(403/ptm_ratio, 66.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1/ptm_ratio, 3.5/ptm_ratio)  ,  new b2Vec2(48/ptm_ratio, 50.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 71/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 4/ptm_ratio)  ] ,
                                                [   new b2Vec2(64/ptm_ratio, 58.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 71/ptm_ratio)  ,  new b2Vec2(48/ptm_ratio, 50.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(93/ptm_ratio, 66.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 72.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 71/ptm_ratio)  ,  new b2Vec2(64/ptm_ratio, 58.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(230/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 72.5/ptm_ratio)  ,  new b2Vec2(93/ptm_ratio, 66.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(230/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(578/ptm_ratio, 72.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 72.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(376/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(230/ptm_ratio, 69.5/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 68.5/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
