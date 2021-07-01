package common.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class DataMap{
	
	static Map<String, Object> map = new HashMap<String, Object>();

	public Object get(String key) {
		return map.get(key);
	}
	
	public void put(String key, Object value) {
		map.put(key, value);
	}
	
	public Object remove(String key) {
		return map.remove(key);
	}
	
	public boolean containsKey(String key) {
		return map.containsKey(key);
	}
	
	public boolean containsValue(String key) {
		return map.containsValue(key);
	}
	
	public void clear() {
		map.clear();
	}
	
	public Set<Entry<String, Object>> entrySet(){
		return map.entrySet();
	}
	
	public Set<String> keySet(){
		return map.keySet();
	}
	
	public void putAll(Map<?extends String, ?extends Object> m) {
		map.putAll(m);
	}
	
	public Map<String, Object> getMap(){
		return map;
	}
}