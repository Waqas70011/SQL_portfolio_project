
DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE Table #PercentPopulationVaccinated
(
Continent NVARCHAR(255),
locaiton nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingpeopleVaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(float, vac.new_vaccinations)) OVER 
	(PARTITION BY dea.location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM Portfoliosql..CovidDeaths dea
JOIN Portfoliosql..CovidVaccincation vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100 PercentageVaccinated 
FROM #PercentPopulationVaccinated