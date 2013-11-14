package th.co.aoe.imake.pst.backoffice.domain;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;

public class MyUserDetails extends org.springframework.security.core.userdetails.User {
	private MyUser myUser;

	public MyUserDetails(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, authorities);
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public MyUser getMyUser() {
		return myUser;
	}

	public void setMyUser(MyUser myUser) {
		this.myUser = myUser;
	}

}
