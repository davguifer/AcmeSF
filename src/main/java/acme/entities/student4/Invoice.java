
package acme.entities.student4;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PastOrPresent;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.URL;

import acme.client.data.AbstractEntity;
import acme.client.data.datatypes.Money;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Invoice extends AbstractEntity {

	// Serialisation identifier -----------------------------------------------
	private static final long	serialVersionUID	= 1L;

	// Attributes -------------------------------------------------------------
	@Pattern(regexp = "^IN-[0-9]{4}-[0-9]{4}$", message = "{validation.invoices.code}")
	@NotBlank
	@Column(unique = true)
	private String				code;

	@Temporal(TemporalType.TIMESTAMP)
	@NotNull
	@PastOrPresent
	private Date				registrationTime;

	@Temporal(TemporalType.TIMESTAMP)
	@NotNull
	private Date				dueDate;

	private Money				quantity;

	@DecimalMin(value = "0.0")
	@DecimalMax(value = "1.0")
	private double				tax;

	@URL
	@Length(max = 255)
	private String				link;

	private boolean				published;


	// Derived attributes -----------------------------------------------------
	@Transient
	private Double totalAmount() {
		return this.getQuantity().getAmount() + this.getTax() * this.getQuantity().getAmount();
	}


	// Relationships ----------------------------------------------------------
	@NotNull
	@Valid
	@ManyToOne(optional = false)
	private Sponsorship sponsorship;
}
