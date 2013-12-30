package th.co.imake.syndome.bpm.backoffice.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
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

import th.co.imake.syndome.bpm.backoffice.domain.MyUser;
import th.co.imake.syndome.bpm.backoffice.domain.MyUserDetails;
import th.co.imake.syndome.bpm.backoffice.repository.UserRepository;
import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.constant.ServiceConstant;
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
	private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private SynDomeBPMService synDomeBPMService;
	@PersistenceUnit(unitName = "hibernatePersistenceUnit")
    private EntityManagerFactory entityManagerFactory;

	/**
	 * Returns a populated {@link UserDetails} object. 
	 * The username is first retrieved from the database and then mapped to 
	 * a {@link UserDetails} object.
	 */
	 public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		try {
			th.co.imake.syndome.bpm.backoffice.domain.User domainUserContact= userRepository.findByUsername(username);
			boolean enabled = true;
			boolean accountNonExpired = true;
			boolean credentialsNonExpired = true;
			boolean accountNonLocked = true;
			boolean isAdmin=false;
			/*return new User(
					//domainUser.getUsername(), 
					domainUser.getFirstName(),
					domainUser.getPassword().toLowerCase(),
					enabled,
					accountNonExpired,
					credentialsNonExpired,
					accountNonLocked,
					getAuthorities(domainUser.getRole().getRole()));*/
		
			/*if(domainUserContact.getType()!=null && domainUserContact.getType().equals("1")){
				isAdmin=true;
			}*/
			MyUserDetails user=new MyUserDetails(domainUserContact.getUsername(),  
					domainUserContact.getPassword().toLowerCase(),
					enabled,
					accountNonExpired,
					credentialsNonExpired,
					accountNonLocked,
					//getAuthorities(domainUser.getRole().getRole()));
					getAuthorities(getRolesMapping(domainUserContact.getBpmRole(),isAdmin)));
					//getAuthorities(getRolesMapping(rcId,isAdmin)));
			MyUser myUser=new MyUser(domainUserContact.getFirstName()+" "+domainUserContact.getLastName());
			user.setMyUser(myUser);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	 public  Set<th.co.imake.syndome.bpm.xstream.BpmRoleType> getRolesMapping(th.co.imake.syndome.bpm.backoffice.domain.BpmRole bpmrole,boolean isAdmin){
		  Set<th.co.imake.syndome.bpm.xstream.BpmRoleType> role =new HashSet<th.co.imake.syndome.bpm.xstream.BpmRoleType>();
		  th.co.imake.syndome.bpm.xstream.BpmRoleType defualt= new th.co.imake.syndome.bpm.xstream.BpmRoleType();
		   defualt.setBpmRoleTypeName("ROLE_USER");
		   role.add(defualt); 
		   if(isAdmin){
			   th.co.imake.syndome.bpm.xstream.BpmRoleType admin= new th.co.imake.syndome.bpm.xstream.BpmRoleType();
				admin.setBpmRoleTypeName("ROLE_ADMIN");
				role.add(admin);
		   }
		  if(bpmrole!=null && bpmrole.getBpmRoleId()!=null){
       	  String role_sql="SELECT  bpm_role_type_name FROM "+ServiceConstant.SCHEMA+".BPM_ROLE_MAPPING mapping left join " +
       	  		" "+ServiceConstant.SCHEMA+".BPM_ROLE_TYPE role_type on mapping.bpm_role_type_id=role_type.bpm_role_type_id " +
       	  		" where mapping.bpm_role_id="+bpmrole.getBpmRoleId() ;
       	  List list=synDomeBPMService.searchObject(role_sql);
       	  if(list!=null && list.size()>0){
       		  int role_size=list.size();
       		  for (int i = 0; i < role_size; i++) {
       			th.co.imake.syndome.bpm.xstream.BpmRoleType roleType =new th.co.imake.syndome.bpm.xstream.BpmRoleType();
       			roleType.setBpmRoleTypeName((String)list.get(i));
       			role.add(roleType);
       		  }
       	  }
         }
		return role;
	}
	/**
	 * Retrieves a collection of {@link GrantedAuthority} based on a numerical role
	 * @param role the numerical role
	 * @return a collection of {@link GrantedAuthority
	 */
	public Collection<? extends GrantedAuthority> getAuthorities(Set<th.co.imake.syndome.bpm.xstream.BpmRoleType> role) {
		List<GrantedAuthority> authList = getGrantedAuthorities(getRoles(role));
		return authList;
	}
	
	/**
	 * Converts a numerical role to an equivalent list of roles
	 * @param role the numerical role
	 * @return list of roles as as a list of {@link String}
	 */

	public List<String> getRoles(Set<th.co.imake.syndome.bpm.xstream.BpmRoleType> role) {
		List<String> roles = new ArrayList<String>();
		if(role!=null && role.size()>0)
		for (th.co.imake.syndome.bpm.xstream.BpmRoleType key : role) {
			roles.add(key.getBpmRoleTypeName());
		}
		return roles;
	}
	
	public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		return authorities;
	}
}
