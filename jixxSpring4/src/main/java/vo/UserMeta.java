package vo;

public class UserMeta {
	private int user_id;
	private int rep_id;	
	private int channel_id;
	private int alarm_type; //기본적으로 알람 default값은 1, 알람설정을 껐을 시 0
	public UserMeta() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserMeta(int user_id, int rep_id, int channel_id, int alarm_type) {
		super();
		this.user_id = user_id;
		this.rep_id = rep_id;
		this.channel_id = channel_id;
		this.alarm_type = alarm_type;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getRep_id() {
		return rep_id;
	}
	public void setRep_id(int rep_id) {
		this.rep_id = rep_id;
	}
	public int getChannel_id() {
		return channel_id;
	}
	public void setChannel_id(int channel_id) {
		this.channel_id = channel_id;
	}
	public int getAlarm_type() {
		return alarm_type;
	}
	public void setAlarm_type(int alarm_type) {
		this.alarm_type = alarm_type;
	}
	@Override
	public String toString() {
		return "UserMeta [user_id=" + user_id + ", rep_id=" + rep_id + ", channel_id=" + channel_id + ", alarm_type="
				+ alarm_type + "]";
	}

	

}
