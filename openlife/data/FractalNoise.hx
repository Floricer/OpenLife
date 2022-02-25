package openlife.data;

#if cpp
import cpp.UInt64;
import cpp.UInt32;
#elseif hl
import UInt as UInt64;
import UInt as UInt32;
#end

/*
	class FractalNoise
	{

	//private static inline var XX_PRIME32_1:UInt64 = cast 2654435761;
	//private static inline var XX_PRIME32_2:UInt64 = cast 2246822519;
	//private static inline var XX_PRIME32_3:UInt64 = cast 3266489917;
	//private static inline var XX_PRIME32_4:UInt64 = cast 668265263;
	//private static inline var XX_PRIME32_5:UInt64 = cast 374761393;


	private static inline var XX_PRIME32_1:UInt64 = cast 26544357;
	private static inline var XX_PRIME32_2:UInt64 = cast 22468225;
	private static inline var XX_PRIME32_3:UInt64 = cast 32664899;
	private static inline var XX_PRIME32_4:UInt64 = cast 6682652;
	private static inline var XX_PRIME32_5:UInt64 = cast 3747613;
	private static var xxSeed:UInt32 = 0;
	public static function setXYRandomSeed(inSeed:UInt32) 
	{
		xxSeed = inSeed;
	}
	public static function xxTweakedHash2D(inX:UInt32,inY:UInt32):UInt32
	{
		var h32:UInt32 = cast(xxSeed + inX + XX_PRIME32_5);
		var add:UInt32 = cast(inY * XX_PRIME32_3); 
		h32 += add;
		h32 *= cast XX_PRIME32_2;
		h32 ^= cast h32 >> 13;
		h32 *= cast XX_PRIME32_3;
		h32 ^= cast h32 >> 16;
		return h32;
	}
	//private static var oneOverIntMax = 1.0 / 4294967295;
	private static var oneOverIntMax = 1.0 / 429496;
	public static function getXYRandom(inX:Int,inY:Int):Float 
	{
		return xxTweakedHash2D(inX,inY) * oneOverIntMax;
	}
	public static function getXYRandomBN(inX:Float,inY:Float):Float
	{
		var floorX:Int = Math.floor(inX);
		var ceilX = floorX + 1;
		var floorY = Math.floor(inY);
		var ceilY = floorY + 1;

		var cornerA1:Float = xxTweakedHash2D(floorX,floorY);
		var cornerA2:Float = xxTweakedHash2D(ceilX,floorY);

		var cornerB1 = xxTweakedHash2D(floorX,ceilY);
		var cornerB2 = xxTweakedHash2D(ceilX,ceilY);

		var xOffset:Float = inX - floorX;
		var yOffset:Float = inY - floorY;

		var topBlend:Float = cornerA2 * xOffset + (1-xOffset) * cornerA1;
		var bottomBlend:Float = cornerB2 * xOffset + (1-xOffset) * cornerB1;

		return bottomBlend * yOffset + (1-yOffset) * topBlend;
	}
	public static function getXYFractal(inX:Int,inY:Int,inRoughness:Float,inScale:Float):Float
	{
		var b:Float = inRoughness;
		var a:Float = 1 - b;

		var sum:Float = 0 +
			a * getXYRandomBN(inX/(32 * inScale),inY/(32 * inScale)) +
				b * (
					a * getXYRandomBN(inX/(16 * inScale),inY/(16 * inScale)) + 
						b * (
							a * getXYRandomBN(inX/(8 * inScale),inY/(8 * inScale)) +
								b * (
									a * getXYRandomBN(inX/(4 * inScale),inY/(4 * inScale)) +
										b * (
											a * getXYRandomBN(inX/(2 * inScale),inY/(2 * inScale)) +
												b * (
														a * getXYRandomBN(inX/inScale,inY/inScale)
												)))));
		return sum * oneOverIntMax;
	}
	}
 */
