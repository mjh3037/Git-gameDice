package common.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class CommonUtil {
	
	private static final int MAX_VARIABLE_LENGTH= 30;
	
	public static void printMap(Map<String, Object> map) {
		
		Iterator<Entry<String, Object>> iterator = map.entrySet().iterator();
		Entry<String, Object> entry = null;
		String key = null;
		
//		System.out.println(map.entrySet().iterator());
//		System.out.println(map);
		
		while(iterator.hasNext()) {
			entry = iterator.next();
			key = entry.getKey();
			
//			System.out.println("key: " + entry.getKey());
			
			if( MAX_VARIABLE_LENGTH > key.length()) {
				
			}
		}
//		System.out.println("keylength: "+ key);
		
	}
}
