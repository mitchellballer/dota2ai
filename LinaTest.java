package de.lighti.dota2.bot;

public class LinaTest {
	@Test
	public void testName(){
		String s = "npc_dota_hero_lina";
		Lina l = new Lina();
		assertEquals(s, l.MY_HERO_NAME);
	}
	
}
