package vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Post {
	private int post_id; 
	private int repost_id; //Default 값은 0으로 null 값을 넣을시 예기치 못한 오류가 생길 수 있으므로
	private String nickname;
	private String content;
	private int user_id;
	private Date logdate; //처음 글 작성시간
	private Date update; //수정시 들어가는 값 
	private String file_thumbnail; //저장한파일 썸네일파일 명
	private String file_original; //저장한 파일 오리지널 파일명
	private int post_status; //게시물 상태 Default = 1 : 1값인 데이터만 조회 , 삭제하기능할 경우 : 0으로 업데이트 /저장소 참여 했을때 3
	private int channel_id; //저장소의 어디 채널에 해당하는 것인지.
	private MultipartFile file;
	private String fileName;
	public Post() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Post(int post_id, int repost_id, String nickname, String content, int user_id, Date logdate, Date update,
			String file_thumbnail, String file_original, int post_status, int channel_id, MultipartFile file,
			String fileName) {
		super();
		this.post_id = post_id;
		this.repost_id = repost_id;
		this.nickname = nickname;
		this.content = content;
		this.user_id = user_id;
		this.logdate = logdate;
		this.update = update;
		this.file_thumbnail = file_thumbnail;
		this.file_original = file_original;
		this.post_status = post_status;
		this.channel_id = channel_id;
		this.file = file;
		this.fileName = fileName;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public int getRepost_id() {
		return repost_id;
	}
	public void setRepost_id(int repost_id) {
		this.repost_id = repost_id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Date getLogdate() {
		return logdate;
	}
	public void setLogdate(Date logdate) {
		this.logdate = logdate;
	}
	public Date getUpdate() {
		return update;
	}
	public void setUpdate(Date update) {
		this.update = update;
	}
	public String getFile_thumbnail() {
		return file_thumbnail;
	}
	public void setFile_thumbnail(String file_thumbnail) {
		this.file_thumbnail = file_thumbnail;
	}
	public String getFile_original() {
		return file_original;
	}
	public void setFile_original(String file_original) {
		this.file_original = file_original;
	}
	public int getPost_status() {
		return post_status;
	}
	public void setPost_status(int post_status) {
		this.post_status = post_status;
	}
	public int getChannel_id() {
		return channel_id;
	}
	public void setChannel_id(int channel_id) {
		this.channel_id = channel_id;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	@Override
	public String toString() {
		return "Post [post_id=" + post_id + ", repost_id=" + repost_id + ", nickname=" + nickname + ", content="
				+ content + ", user_id=" + user_id + ", logdate=" + logdate + ", update=" + update + ", file_thumbnail="
				+ file_thumbnail + ", file_original=" + file_original + ", post_status=" + post_status + ", channel_id="
				+ channel_id + ", file=" + file + ", fileName=" + fileName + "]";
	}
	
}
