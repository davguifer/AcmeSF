
package acme.features.manager.userStory;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import acme.client.data.models.Dataset;
import acme.client.services.AbstractService;
import acme.client.views.SelectChoices;
import acme.entities.student1.Priority;
import acme.entities.student1.ProjectUserStory;
import acme.entities.student1.UserStory;
import acme.roles.Manager;

@Service
public class ManagerUserStoryDeleteService extends AbstractService<Manager, UserStory> {

	// Internal state ---------------------------------------------------------

	@Autowired
	private ManagerUserStoryRepository repository;

	// AbstractService interface ----------------------------------------------


	@Override
	public void authorise() {
		boolean status;
		int managerRequestId;
		Manager manager;
		int userStoryId;
		UserStory userStory;

		userStoryId = super.getRequest().getData("id", int.class);
		userStory = this.repository.findUserStoryById(userStoryId);
		manager = userStory == null ? null : userStory.getManager();
		managerRequestId = super.getRequest().getPrincipal().getActiveRoleId();
		if (manager != null)
			status = !userStory.isPublished() && super.getRequest().getPrincipal().hasRole(manager) //
				&& manager.getId() == managerRequestId;
		else
			status = false;

		super.getResponse().setAuthorised(status);
	}

	@Override
	public void load() {
		UserStory object;
		int userStoryId;

		userStoryId = super.getRequest().getData("id", int.class);
		object = this.repository.findUserStoryById(userStoryId);

		super.getBuffer().addData(object);
	}

	@Override
	public void bind(final UserStory object) {
		assert object != null;

		super.bind(object, "title", "description", "estimatedCost", "acceptanceCriteria", "priority", "link");
	}

	@Override
	public void validate(final UserStory object) {
		assert object != null;
	}

	@Override
	public void perform(final UserStory object) {
		assert object != null;

		Collection<ProjectUserStory> projectUserStory;

		projectUserStory = this.repository.findManyProjectUserStoryByUserStoryId(object.getId());
		this.repository.deleteAll(projectUserStory);
		this.repository.delete(object);
	}

	@Override
	public void unbind(final UserStory object) {
		assert object != null;

		SelectChoices choices;
		Dataset dataset;

		choices = SelectChoices.from(Priority.class, object.getPriority());

		dataset = super.unbind(object, "title", "description", "estimatedCost", "acceptanceCriteria", //
			"link", "published");
		dataset.put("manager", object.getManager().getUserAccount().getUsername());
		dataset.put("priority", choices.getSelected().getKey());
		dataset.put("priorities", choices);

		super.getResponse().addData(dataset);
	}
}
