package th.co.aoe.imake.pst.backoffice.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import th.co.aoe.imake.pst.backoffice.domain.User;

public interface UserRepository extends JpaRepository<User,Long> {
//public interface UserRepository extends JpaRepository<UserContact, Long> {
	
	User findByUsername(String username);
	//UserContact findByUsername(String username);
}
