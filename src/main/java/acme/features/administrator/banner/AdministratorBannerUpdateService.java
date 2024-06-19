
package acme.features.administrator.banner;

import java.time.temporal.ChronoUnit;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import acme.client.data.accounts.Administrator;
import acme.client.data.models.Dataset;
import acme.client.helpers.MomentHelper;
import acme.client.services.AbstractService;
import acme.entities.group.Banner;

@Service
public class AdministratorBannerUpdateService extends AbstractService<Administrator, Banner> {

	@Autowired
	protected AdministratorBannerRepository repository;


	@Override
	public void authorise() {
		super.getResponse().setAuthorised(true);
	}

	@Override
	public void load() {
		Banner object;
		int id;
		id = super.getRequest().getData("id", int.class);
		object = this.repository.findOneBannerById(id);
		super.getBuffer().addData(object);
	}

	@Override
	public void bind(final Banner object) {
		assert object != null;
		super.bind(object, "displayStart", "displayFinish", "linkPicture", "slogan", "linkTarget");

	}
	@Override
	public void validate(final Banner object) {
		assert object != null;
		Date fechaMaxima = new Date(7258114799000L);
		object.setInstantiationUpdateMoment(MomentHelper.getCurrentMoment());
		if (!super.getBuffer().getErrors().hasErrors("displayStart")) {
			super.state(MomentHelper.isAfter(object.getDisplayStart(), object.getInstantiationUpdateMoment()), "displayStart", "administrator.banner.form.error.startDisplayPeriod");
			super.state(object.getDisplayStart().before(fechaMaxima), "displayStart", "administrator.banner.form.error.maximunPeriod");
		}

		if (!super.getBuffer().getErrors().hasErrors("displayFinish")) {
			Date maximumPeriod;
			super.state(object.getDisplayFinish().before(fechaMaxima), "displayFinish", "administrator.banner.form.error.maximunPeriod");
			maximumPeriod = MomentHelper.deltaFromMoment(object.getDisplayStart(), 7, ChronoUnit.DAYS);
			super.state(MomentHelper.isAfterOrEqual(object.getDisplayFinish(), maximumPeriod) && object.getDisplayFinish().after(object.getDisplayStart()), "displayFinish", "administrator.banner.form.error.endDisplayPeriod");

		}
	}
	@Override
	public void perform(final Banner object) {
		assert object != null;
		object.setInstantiationUpdateMoment(MomentHelper.getCurrentMoment());
		this.repository.save(object);
	}

	@Override
	public void unbind(final Banner object) {
		assert object != null;
		Dataset dataset;
		dataset = super.unbind(object, "instantiationUpdateMoment", "displayStart", "displayFinish", "linkPicture", "slogan", "linkTarget");
		super.getResponse().addData(dataset);
	}

}
