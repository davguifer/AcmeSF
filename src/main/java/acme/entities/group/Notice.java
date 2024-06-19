
package acme.entities.group;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.URL;

import acme.client.data.AbstractEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Notice extends AbstractEntity {

	// Serialisation identifier ----------------------------------------------

	private static final long	serialVersionUID	= 1L;

	// Attributes ------------------------------------------------------------

	@Temporal(TemporalType.TIMESTAMP)
	@NotNull
	@Past
	private Date				instantiationMoment;

	@NotBlank
	@Length(max = 75)
	private String				title;

	@NotBlank
	@Length(max = 75)
	@Pattern(regexp = "^[\\w-]+-[\\w-]+,[a-zA-Z ]+$", message = "author doesnt follow format “〈username〉 - 〈surname, name〉")
	private String				author;

	@NotBlank
	@Length(max = 100)
	private String				message;

	@Email
	@Length(max = 255)
	private String				email;

	@URL
	@Length(max = 255)
	private String				link;

	// Derived attributes ----------------------------------------------------- 

	// Relationships ----------------------------------------------------------

}
