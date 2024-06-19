<%@page%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="acme" uri="http://acme-framework.org/"%>


<table class="table table-sm">
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.codeAudit-static"/>
		</th>
		<td>
			<jstl:choose>
				<jstl:when test="${staticCodeAudits != null}">
					<acme:print value="${staticCodeAudits}"/>
				</jstl:when>
				<jstl:when test="${staticCodeAudits == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.codeAudit-dynamic"/>
		</th>
		<td>
			<jstl:choose>
				<jstl:when test="${dynamicCodeAudits != null}">
					<acme:print value="${dynamicCodeAudits}"/>
				</jstl:when>
				<jstl:when test="${dynamicCodeAudits == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.averageAuditRecords"/>
		</th>
		<td>
			<jstl:choose>
				<jstl:when test="${averageNumAuditRecords != null}">
					<acme:print value="${averageNumAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${averageNumAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
		<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.deviationAuditRecords"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${deviationNumAuditRecords != null}">
					<acme:print value="${deviationNumAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${deviationNumAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.minNumAuditRecords"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${minNumAuditRecords != null}">
					<acme:print value="${minNumAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${minNumAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.maxNumAuditRecords"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${maxNumAuditRecords != null}">
					<acme:print value="${maxNumAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${maxNumAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.averageAuditRecordsPeriodLength"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${averageTimeAuditRecords != null}">
					<acme:print value="${averageTimeAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${averageTimeAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.deviationAuditRecordsPeriodLength"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${deviationTimeAuditRecords != null}">
					<acme:print value="${deviationTimeAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${deviationTimeAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.minAuditRecordsPeriodLength"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${minTimeAuditRecords != null}">
					<acme:print value="${minTimeAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${minTimeAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
	<tr>
		<th scope="row">
			<acme:message code="auditor.auditorDashboard.form.label.maxAuditRecordsPeriodLength"/>
		</th>
		<td>
		<jstl:choose>
				<jstl:when test="${maxTimeAuditRecords != null}">
					<acme:print value="${maxTimeAuditRecords}"/>
				</jstl:when>
				<jstl:when test="${maxTimeAuditRecords == null}">
					<acme:print value="N/A"/>
				</jstl:when>
			</jstl:choose>
		</td>
	</tr>
</table>

<jstl:choose>
	<jstl:when test="${staticCodeAudits != 0 || dynamicCodeAudits != 0 }">
		<h3><acme:message code="auditor.auditorDashboard.form.label.codeAudit.type.information"/></h3>
		<div>
			<canvas id="canvas"></canvas>
		</div>
				<script type="text/javascript">
			$(document).ready(function() {
				var data = {
					labels : [
							"STATIC", "DYNAMIC"
					],
					datasets : [
						{
							data : [
								<jstl:out value="${staticCodeAudits}"/>, 
								<jstl:out value="${dynamicCodeAudits}"/>,
							],
							backgroundColor: [
								'rgb(30, 190, 104)',
						    	'rgb(44, 172, 240)',
						    ]
						}
					]
				};
	
				var canvas, context;
				canvas = document.getElementById("canvas");
				context = canvas.getContext("2d");
				new Chart(context, {
					type : "doughnut",
					data : data,
				});
			});
		</script>
	</jstl:when>
</jstl:choose>

<jstl:choose>
	<jstl:when test="${averageNumAuditRecords != null && deviationNumAuditRecords != null && minNumAuditRecords != null && maxNumAuditRecords != null}">

		<h3><acme:message code="auditor.auditorDashboard.form.label.codeAudit.auditRecord.information"/></h3>
		<div>
			<canvas id="canvas0"></canvas>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {
				var data = {
					labels : [
						"AVERAGE", "DEVIATION", "MIN","MAX"
					],
					datasets : [
						{
							data : [
								<jstl:out value="${averageNumAuditRecords}"/>, 
								<jstl:out value="${deviationNumAuditRecords}"/>, 
								<jstl:out value="${minNumAuditRecords}"/>,
								<jstl:out value="${maxNumAuditRecords}"/>
							],
							backgroundColor: [
								'rgb(30, 190, 104)',
						    	'rgb(44, 172, 240)',
						    	'rgb(245, 215, 91)',
						      	'rgb(220, 180, 248)'
						    ]
						}
					]
				};	
				
				var options = {
						scales : {
							yAxes : [
								{
									ticks : {
										suggestedMin : 0.0,
										suggestedMax : 40.0
									}
									}
							]
						},
						legend : {
							display : false
						}
					};
				
				var canvas, context;
				canvas = document.getElementById("canvas0");
				context = canvas.getContext("2d");
				new Chart(context, {
					type : "bar",
					data : data,
					options : options
				});
			});
		</script>
	</jstl:when>
</jstl:choose>

<jstl:choose>
	<jstl:when test="${averageTimeAuditRecords != null && deviationTimeAuditRecords != null && minTimeAuditRecords != null && maxTimeAuditRecords != null}">

		<h3><acme:message code="auditor.auditorDashboard.form.label.auditRecord.periodLength.information"/></h3>
		<div>
			<canvas id="canvas0"></canvas>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {
				var data = {
					labels : [
						"AVERAGE", "DEVIATION", "MIN","MAX"
					],
					datasets : [
						{
							data : [
								<jstl:out value="${averageTimeAuditRecords}"/>, 
								<jstl:out value="${deviationTimeAuditRecords}"/>, 
								<jstl:out value="${minTimeAuditRecords}"/>,
								<jstl:out value="${maxTimeAuditRecords}"/>
							],
							backgroundColor: [
								'rgb(30, 190, 104)',
						    	'rgb(44, 172, 240)',
						    	'rgb(245, 215, 91)',
						      	'rgb(220, 180, 248)'
						    ]
						}
					]
				};	
				
				var options = {
						scales : {
							yAxes : [
								{
									ticks : {
										suggestedMin : 0.0,
										suggestedMax : 1000.0
									}
									}
							]
						},
						legend : {
							display : false
						}
					};
				
				var canvas, context;
				canvas = document.getElementById("canvas0");
				context = canvas.getContext("2d");
				new Chart(context, {
					type : "bar",
					data : data,
					options : options
				});
			});
		</script>
	</jstl:when>
</jstl:choose>