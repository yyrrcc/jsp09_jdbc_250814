package jsp09_jdbc_250814.pack;

public class MemberDTO {
	private String memid;
	private String mempw;
	private String memname;
	private String mememail;
	private String memdate;

	public MemberDTO() {
		super();
	}
	
	public MemberDTO(String memid, String mempw, String memname, String mememail, String memdate) {
		super();
		this.memid = memid;
		this.mempw = mempw;
		this.memname = memname;
		this.mememail = mememail;
		this.memdate = memdate;
	}

	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getMempw() {
		return mempw;
	}
	public void setMempw(String mempw) {
		this.mempw = mempw;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getMememail() {
		return mememail;
	}
	public void setMememail(String mememail) {
		this.mememail = mememail;
	}
	public String getMemdate() {
		return memdate;
	}
	public void setMemdate(String memdate) {
		this.memdate = memdate;
	}

	
}
