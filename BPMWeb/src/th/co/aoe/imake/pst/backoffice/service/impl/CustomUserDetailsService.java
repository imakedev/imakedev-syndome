package th.co.aoe.imake.pst.backoffice.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import th.co.aoe.imake.pst.backoffice.domain.MyUser;
import th.co.aoe.imake.pst.backoffice.domain.MyUserDetails;
import th.co.aoe.imake.pst.backoffice.domain.Role;
import th.co.aoe.imake.pst.backoffice.repository.UserRepository;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.constant.ServiceConstant;
//import java.util.logging.Logger;
//import org.apache.log4j.Logger;
//import ch.qos.logback.classic.Logger;

/**
 * A custom {@link UserDetailsService} where user information
 * is retrieved from a JPA repository
 */
@Service
@Transactional(readOnly = true)
public class CustomUserDetailsService implements UserDetailsService {
	//private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private PSTService missExamService;
	/*@PersistenceContext
	private EntityManager em;*/
	@PersistenceUnit(unitName = "hibernatePersistenceUnit")
    private EntityManagerFactory entityManagerFactory;

	/**
	 * Returns a populated {@link UserDetails} object. 
	 * The username is first retrieved from the database and then mapped to 
	 * a {@link UserDetails} object.
	 */
	 public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
	//public UserDetails loadUserByUsername(String username) {
		logger.debug(" xxxxxxxxxxxxxxxxxxxxxxxxxxxx into loadUserByUsername "+username);
		try {
			  th.co.aoe.imake.pst.backoffice.domain.User domainUserContact= userRepository.findByUsername(username);
	      
			logger.debug(" xxxxxxxxxxxxxxxxxxxxxxxxxxxx affter loadUserByUsername "+domainUserContact);
			
			boolean enabled = true;
			boolean accountNonExpired = true;
			boolean credentialsNonExpired = true;
			boolean accountNonLocked = true;
		 
			/*return new User(
					//domainUser.getUsername(), 
					domainUser.getFirstName(),
					domainUser.getPassword().toLowerCase(),
					enabled,
					accountNonExpired,
					credentialsNonExpired,
					accountNonLocked,
					getAuthorities(domainUser.getRole().getRole()));*/
		
         
			MyUserDetails user=new MyUserDetails(domainUserContact.getUsername(),  
					domainUserContact.getPassword().toLowerCase(),
					enabled,
					accountNonExpired,
					credentialsNonExpired,
					accountNonLocked,
					//getAuthorities(domainUser.getRole().getRole()));
					getAuthorities(domainUserContact.getRole()));
					//getAuthorities(getRolesMapping(rcId,isAdmin)));
			MyUser myUser=new MyUser(domainUserContact.getFirstName()+" "+domainUserContact.getLastName());
			/*th.co.aoe.imake.pst.xstream.MissContact missContact= missExamService.findMissContactByUsername(domainUserContact.getUsername());
			myUser.setMissContact(missContact);*/
			user.setMyUser(myUser);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
//	public  Set<th.co.aoe.imake.pst.xstream.RoleType> getRolesMapping(RoleContact roleContact,boolean isAdmin){
	/**
	 * Retrieves a collection of {@link GrantedAuthority} based on a numerical role
	 * @param role the numerical role
	 * @return a collection of {@link GrantedAuthority
	 */
	public Collection<? extends GrantedAuthority> getAuthorities(Set<Role> role) {
		List<GrantedAuthority> authList = getGrantedAuthorities(getRoles(role));
		return authList;
	}
	/*public Collection<? extends GrantedAuthority> getAuthorities(Set<th.co.aoe.imake.pst.xstream.RoleType> role) {
		List<GrantedAuthority> authList = getGrantedAuthorities(getRoles(role));
		return authList;
	}*/
	
	/**
	 * Converts a numerical role to an equivalent list of roles
	 * @param role the numerical role
	 * @return list of roles as as a list of {@link String}
	 */
	public List<String> getRoles(Set<Role> role) {
		List<String> roles = new ArrayList<String>();
		if(role!=null && role.size()>0)
		for (Role key : role) {
			roles.add(key.getRole());
		}
		return roles;
	}
	/*public List<String> getRoles(Set<th.co.aoe.imake.pst.xstream.RoleType> role) {
		List<String> roles = new ArrayList<String>();
		if(role!=null && role.size()>0)
		for (th.co.aoe.imake.pst.xstream.RoleType key : role) {
			roles.add(key.getRole());
		}
		return roles;
	}*/
	
	/**
	 * Wraps {@link String} roles to {@link SimpleGrantedAuthority} objects
	 * @param roles {@link String} of roles
	 * @return list of granted authorities
	 */
	/*public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		return authorities;
	}*/
	public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
		return authorities;
	}
}
