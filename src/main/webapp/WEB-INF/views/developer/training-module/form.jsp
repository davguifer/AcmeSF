<%--
- form.jsp
-
- Copyright (C) 2012-2024 Rafael Corchuelo.
-
- In keeping with the traditional purpose of furthering education and research, it is
- the policy of the copyright owner to permit non-commercial use and redistribution of
- this software. It has been tested carefully, but it is not guaranteed for any particular
- purposes.  The copyright owner does not offer any warranties or representations, nor do
- they accept any liabilities with respect to them.
--%>

<%@page%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="acme" uri="http://acme-framework.org/"%>

<acme:form> 
	<acme:input-textbox code="developer.trainingModule.form.label.code" path="code"/>
	<acme:input-textbox code="developer.trainingModule.form.label.details" path="details"/>
	<acme:input-textbox code="developer.trainingModule.form.label.link" path="link"/>
	<acme:input-integer code="developer.trainingModule.form.label.totalTime" path="totalTime"/>
	<jstl:choose>
		<jstl:when test="${_command == 'show' && published == true}">
			<acme:input-moment code="developer.trainingModule.form.label.creationMoment" path="creationMoment"/>
			<acme:input-moment code="developer.trainingModule.form.label.updateMoment" path="updateMoment"/>	
		</jstl:when>
	</jstl:choose>
	<jstl:choose>
	<jstl:when test="${_command == 'show' && published == true }">
			<acme:input-textbox code="developer.trainingModule.form.label.projectTitle" path="projectTitle"/>
			<acme:input-textbox code="developer.trainingModule.form.label.difficultyLevel" path="difficultyLevel"/>	
		</jstl:when>
		<jstl:when test="${acme:anyOf(_command, 'show|update|delete|publish') && published == false}">
			<acme:input-select code="developer.trainingModule.form.label.project" path="project" choices="${projects}"/>
			<acme:input-select code="developer.trainingModule.form.label.difficultyLevel" path="difficultyLevel" choices="${difficulties}"/>		
		</jstl:when>
	</jstl:choose>
	
	<jstl:choose>
		<jstl:when test="${_command == 'show' && published == true}">
			<acme:button code="developer.trainingModule.form.button.trainingSession" action="/developer/training-session/list?masterId=${id}"/>			
		</jstl:when>
		<jstl:when test="${acme:anyOf(_command, 'show|update|delete|publish') && published == false}">
		<acme:button code="developer.trainingModule.form.button.trainingSession" action="/developer/training-session/list?masterId=${id}"/>
			<acme:submit code="developer.trainingModule.form.button.update" action="/developer/training-module/update"/>
			<acme:submit code="developer.trainingModule.form.button.delete" action="/developer/training-module/delete"/>
			<acme:submit code="developer.trainingModule.form.button.publish" action="/developer/training-module/publish"/>
		</jstl:when>
		<jstl:when test="${_command == 'create'}">
		<acme:input-select code="developer.trainingModule.form.label.project" path="project" choices="${projects}"/>
		<acme:input-select code="developer.trainingModule.form.label.difficultyLevel" path="difficultyLevel" choices="${difficulties}"/>	
			<acme:submit code="developer.trainingModule.list.button.create" action="/developer/training-module/create"/>
		</jstl:when>
	</jstl:choose>
</acme:form>